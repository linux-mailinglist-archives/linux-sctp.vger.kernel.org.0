Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140FA726332
	for <lists+linux-sctp@lfdr.de>; Wed,  7 Jun 2023 16:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjFGOpz (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 7 Jun 2023 10:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbjFGOpy (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 7 Jun 2023 10:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BFA1BD2;
        Wed,  7 Jun 2023 07:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 532816403E;
        Wed,  7 Jun 2023 14:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55874C433D2;
        Wed,  7 Jun 2023 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686149151;
        bh=KYxbixY/YPcTPmWMMjEzFB2YgbL02WvqegnlW8x4q/8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iD70bf4rX5r1dba/J3aCUPj3qSHuwuhLe6KYypwKppjNruVQswPc0WhssUqXzDXxr
         7PFmObSTK8grCkIhUSwN6suorixLko5WIbw+HZGd61Z9uQFIfkdCwc5e1J4w2D05XL
         y+P4T2nMRuVKt3EGjCjMNBFlLkLjB+v5G7MmRXAxNNLvO2p/yBGffzVS27M+OLB9C4
         LUfC9Fx2FjoyrainzfFJjYiUvof0apI7mIwDjn1I7/bWlBvj/VdDT0ZxoKvfFjENzr
         zvTcZOcG5DxQtqFiM1K36FfKZzPdh1GgLTkHGglfgdyHiATbwHTpXtpovrINzKBcwW
         BQyN1A1x8Vv4A==
Message-ID: <ef90361e-15b2-7ce8-fcec-21fccebe727e@kernel.org>
Date:   Wed, 7 Jun 2023 08:45:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH net-next v6] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
To:     Breno Leitao <leitao@debian.org>,
        Remi Denis-Courmont <courmisch@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Ido Schimmel <idosch@idosch.org>
Cc:     axboe@kernel.dk, asml.silence@gmail.com, leit@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jason Xing <kernelxing@tencent.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Hangyu Hua <hbh25y@gmail.com>,
        Guillaume Nault <gnault@redhat.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:DCCP PROTOCOL" <dccp@vger.kernel.org>,
        "open list:IEEE 802.15.4 SUBSYSTEM" <linux-wpan@vger.kernel.org>,
        "open list:NETWORKING [MPTCP]" <mptcp@lists.linux.dev>,
        "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
References: <20230606180045.827659-1-leitao@debian.org>
Content-Language: en-US
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230606180045.827659-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On 6/6/23 12:00 PM, Breno Leitao wrote:
> Most of the ioctls to net protocols operates directly on userspace
> argument (arg). Usually doing get_user()/put_user() directly in the
> ioctl callback.  This is not flexible, because it is hard to reuse these
> functions without passing userspace buffers.
> 
> Change the "struct proto" ioctls to avoid touching userspace memory and
> operate on kernel buffers, i.e., all protocol's ioctl callbacks is
> adapted to operate on a kernel memory other than on userspace (so, no
> more {put,get}_user() and friends being called in the ioctl callback).
> 
> This changes the "struct proto" ioctl format in the following way:
> 
>     int                     (*ioctl)(struct sock *sk, int cmd,
> -                                        unsigned long arg);
> +                                        int *karg);
> 
> (Important to say that this patch does not touch the "struct proto_ops"
> protocols)
> 
> So, the "karg" argument, which is passed to the ioctl callback, is a
> pointer allocated to kernel space memory (inside a function wrapper).
> This buffer (karg) may contain input argument (copied from userspace in
> a prep function) and it might return a value/buffer, which is copied
> back to userspace if necessary. There is not one-size-fits-all format
> (that is I am using 'may' above), but basically, there are three type of
> ioctls:
> 
> 1) Do not read from userspace, returns a result to userspace
> 2) Read an input parameter from userspace, and does not return anything
>   to userspace
> 3) Read an input from userspace, and return a buffer to userspace.
> 
> The default case (1) (where no input parameter is given, and an "int" is
> returned to userspace) encompasses more than 90% of the cases, but there
> are two other exceptions. Here is a list of exceptions:
> 
> * Protocol RAW:
>    * cmd = SIOCGETVIFCNT:
>      * input and output = struct sioc_vif_req
>    * cmd = SIOCGETSGCNT
>      * input and output = struct sioc_sg_req
>    * Explanation: for the SIOCGETVIFCNT case, userspace passes the input
>      argument, which is struct sioc_vif_req. Then the callback populates
>      the struct, which is copied back to userspace.
> 
> * Protocol RAW6:
>    * cmd = SIOCGETMIFCNT_IN6
>      * input and output = struct sioc_mif_req6
>    * cmd = SIOCGETSGCNT_IN6
>      * input and output = struct sioc_sg_req6
> 
> * Protocol PHONET:
>   * cmd == SIOCPNADDRESOURCE | SIOCPNDELRESOURCE
>      * input int (4 bytes)
>   * Nothing is copied back to userspace.
> 
> For the exception cases, functions sock_sk_ioctl_inout() will
> copy the userspace input, and copy it back to kernel space.
> 
> The wrapper that prepare the buffer and put the buffer back to user is
> sk_ioctl(), so, instead of calling sk->sk_prot->ioctl(), the callee now
> calls sk_ioctl(), which will handle all cases.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> --

It looks good to me, so:
Reviewed-by: David Ahern <dsahern@kernel.org>

What kind of testing was done with the patch? Would be good to run
through a NOS style of test suites to make sure the ipmr and ip6mr
changes are correct. (cc'ed Ido since the mlxsw crew has a really good
test up)

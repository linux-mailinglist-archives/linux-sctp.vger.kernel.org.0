Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8DB7B5834
	for <lists+linux-sctp@lfdr.de>; Mon,  2 Oct 2023 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbjJBQsn (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 2 Oct 2023 12:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbjJBQsm (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 2 Oct 2023 12:48:42 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03102A9;
        Mon,  2 Oct 2023 09:48:39 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qnM60-0002xv-B8; Mon, 02 Oct 2023 18:48:36 +0200
Date:   Mon, 2 Oct 2023 18:48:36 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>,
        network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH nf] netfilter: handle the connecting collision properly
 in nf_conntrack_proto_sctp
Message-ID: <20231002164836.GA9274@breakpoint.cc>
References: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
 <CADvbK_fE2KGLtqBxFUVikrCxkRjG_eodeHjRuMGWU=og_qk9_A@mail.gmail.com>
 <20231002151808.GD30843@breakpoint.cc>
 <CADvbK_edFWwc3JGyyexCw+vKbpKsbftRDZD34sjRXCCWtGYLYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvbK_edFWwc3JGyyexCw+vKbpKsbftRDZD34sjRXCCWtGYLYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Xin Long <lucien.xin@gmail.com> wrote:
> On Mon, Oct 2, 2023 at 11:18 AM Florian Westphal <fw@strlen.de> wrote:
> >
> > Xin Long <lucien.xin@gmail.com> wrote:
> > > a reproducer is attached.
> > >
> > > Thanks.
> >
> > Do you think its worth it to turn this into a selftest?
> I think so, it's a typical SCTP collision scenario, if it's okay to you
> I'd like to add this to:
> 
> tools/testing/selftests/netfilter/conntrack_sctp_collision.sh

LGTM, thanks!

> should I repost this netfilter patch together with this selftest or I
> can post this selftest later?

Posting it later is fine.

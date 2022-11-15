Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2259462A334
	for <lists+linux-sctp@lfdr.de>; Tue, 15 Nov 2022 21:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiKOUmD (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 15 Nov 2022 15:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiKOUmC (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 15 Nov 2022 15:42:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353EC1B9E6
        for <linux-sctp@vger.kernel.org>; Tue, 15 Nov 2022 12:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668544861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/NB4n5pjIOWLCWn4EONkdNZMDtYpREKPxU/8nqSVRs=;
        b=PFsF2BuaAeAiYY4a+XmR9ojWYXaBN6IfSuoLVwB/yfy6TR3Ceo2b2nNKXZUxT6aBl5eXnp
        wDlAjjAO0Z9Q6a1M+fMlAZlsJY79Zkf+TDr8N6Fi8wXqe5akpvmw93NttenA6mgFqLg/x2
        LOZJZWaNRvOxnkQSTLYKXkXQt0M4v08=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-7-tYdaWD4vPBmeiL3Xt87b2A-1; Tue, 15 Nov 2022 15:41:00 -0500
X-MC-Unique: tYdaWD4vPBmeiL3Xt87b2A-1
Received: by mail-qk1-f200.google.com with SMTP id u5-20020a05620a0c4500b006fb30780443so12709533qki.22
        for <linux-sctp@vger.kernel.org>; Tue, 15 Nov 2022 12:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5/NB4n5pjIOWLCWn4EONkdNZMDtYpREKPxU/8nqSVRs=;
        b=pKMowHn4AfPEVQmIDBxiQMDykrupP6nqK5Y8PkNKDqbdgxQNcQI9jhrKt+4SD84ifT
         DIxfQSUSwz5RADjR2NyKQMY0mO+0fU1QLHvYO54wNTJlVrcFtj9OVYSNusTObnP93/Cg
         9/yVFf3Yl7XFOpeqcIMa6RbhVAIMfu7g/rJdOwz0Lcc7SGoEXf1DLCk07FHbuJL62ozS
         zFilvXao1nIUvYt1cyqLD1dDCpKezhfx6ETyY6gqFtUuCZW8xOQ75ikzS4qIpa2aR7rO
         lsb880xodZy++/aSjUKaa4QFRcJNjuXizo7BrD6+EvlzlFwYaQmB7i9PL62hHG22gqqM
         EpmA==
X-Gm-Message-State: ANoB5pmjwqKEH3MZ4s+A8jdlGsXaPKctS1sWYNrhnpbh6XPqPpRsHHIJ
        dFwTa6/8uZeD59VsyuUJvJLXS1ibDAb18/Dvfdo4QrK4YNxns7LblvsrrCXsN3LGnNz+5h1KBlG
        DeGqDfx/9e5vOJ4zL3T1hPw==
X-Received: by 2002:a05:622a:5c9b:b0:39c:cb9e:3524 with SMTP id ge27-20020a05622a5c9b00b0039ccb9e3524mr18021999qtb.563.1668544859589;
        Tue, 15 Nov 2022 12:40:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4YOyLcXMm3PjCpLco97NLrXzrnIuOiZV4RDwimWi0e7yPD3Ah2WPiXe9MJ4ACF9jxEfz22nw==
X-Received: by 2002:a05:622a:5c9b:b0:39c:cb9e:3524 with SMTP id ge27-20020a05622a5c9b00b0039ccb9e3524mr18021978qtb.563.1668544859332;
        Tue, 15 Nov 2022 12:40:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a254800b006fa16fe93bbsm8802156qko.15.2022.11.15.12.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 12:40:58 -0800 (PST)
Message-ID: <4b84f8ac08cf5d4037bdfefc1927cd05db09804b.camel@redhat.com>
Subject: Re: [PATCH net-next 7/7] selftests: add a selftest for sctp vrf
From:   Paolo Abeni <pabeni@redhat.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        David Ahern <dsahern@gmail.com>,
        Carlo Carraro <colrack@gmail.com>
Date:   Tue, 15 Nov 2022 21:40:53 +0100
In-Reply-To: <CADvbK_eEkE04vC1v-zuD2x6CMtvBmV2HZxPKfAwsF4N0eUi4=g@mail.gmail.com>
References: <cover.1668357542.git.lucien.xin@gmail.com>
         <39a981bc89921aedbff46f9d1e42369e93416d1d.1668357542.git.lucien.xin@gmail.com>
         <49285c832b6ea6fc36eea946206c53cb3c0aea87.camel@redhat.com>
         <CADvbK_eEkE04vC1v-zuD2x6CMtvBmV2HZxPKfAwsF4N0eUi4=g@mail.gmail.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, 2022-11-15 at 10:33 -0500, Xin Long wrote:
> On Tue, Nov 15, 2022 at 5:29 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > On Sun, 2022-11-13 at 11:44 -0500, Xin Long wrote:
> > 
> > > +testup() {
> > > +     ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=1 2>&1 >/dev/null
> > > +     echo -n "TEST 01: nobind, connect from client 1, l3mdev_accept=1, Y "
> > > +     do_test $CLIENT_NS1 || { echo "[FAIL]"; return 1; }
> > > +     echo "[PASS]"
> > > +
> > > +     echo -n "TEST 02: nobind, connect from client 2, l3mdev_accept=1, N "
> > > +     do_test $CLIENT_NS2 && { echo "[FAIL]"; return 1; }
> > > +     echo "[PASS]"
> > > +
> > > +     ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=0 2>&1 >/dev/null
> > > +     echo -n "TEST 03: nobind, connect from client 1, l3mdev_accept=0, N "
> > > +     do_test $CLIENT_NS1 && { echo "[FAIL]"; return 1; }
> > > +     echo "[PASS]"
> > > +
> > > +     echo -n "TEST 04: nobind, connect from client 2, l3mdev_accept=0, N "
> > > +     do_test $CLIENT_NS2 && { echo "[FAIL]"; return 1; }
> > > +     echo "[PASS]"
> > > +
> > > +     echo -n "TEST 05: bind veth2 in server, connect from client 1, N "
> > > +     do_test $CLIENT_NS1 veth2 && { echo "[FAIL]"; return 1; }
> > > +     echo "[PASS]"
> > > +
> > > +     echo -n "TEST 06: bind veth1 in server, connect from client 1, Y "
> > > +     do_test $CLIENT_NS1 veth1 || { echo "[FAIL]"; return 1; }
> > > +     echo "[PASS]"
> > > +
> > > +     echo -n "TEST 07: bind vrf-1 in server, connect from client 1, Y "
> > > +     do_test $CLIENT_NS1 vrf-1 || { echo "[FAIL]"; return 1; }
> > > +     echo "[PASS]"
> > > +
> > > +     echo -n "TEST 08: bind vrf-2 in server, connect from client 1, N "
> > > +     do_test $CLIENT_NS1 vrf-2 && { echo "[FAIL]"; return 1; }
> > > +     echo "[PASS]"
> > > +
> > > +     echo -n "TEST 09: bind vrf-2 in server, connect from client 2, Y "
> > > +     do_test $CLIENT_NS2 vrf-2 || { echo "[FAIL]"; return 1; }
> > > +     echo "[PASS]"
> > > +
> > > +     echo -n "TEST 10: bind vrf-1 in server, connect from client 2, N "
> > > +     do_test $CLIENT_NS2 vrf-1 && { echo "[FAIL]"; return 1; }
> > > +     echo "[PASS]"
> > > +
> > > +     echo -n "TEST 11: bind vrf-1 & 2 in server, connect from client 1 & 2, Y "
> > > +     do_testx vrf-1 vrf-2 || { echo "[FAIL]"; return 1; }
> > > +     echo "[PASS]"
> > > +
> > > +     echo -n "TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, N "
> > > +     do_testx vrf-2 vrf-1 || { echo "[FAIL]"; return 1; }
> > > +     echo "[PASS]"
> > > +}
> > > +
> > > +trap cleanup EXIT
> > > +setup || exit $?
> > > +echo "Testing For SCTP VRF:"
> > > +CLIENT_IP=$CLIENT_IP4 SERVER_IP=$SERVER_IP4 AF="-4" testup && echo "***v4 Tests Done***" &&
> > > +CLIENT_IP=$CLIENT_IP6 SERVER_IP=$SERVER_IP6 AF="-6" testup && echo "***v6 Tests Done***"
> > 
> > To properly integrate with the self-test suite, you need to ensure that
> > the script exits with an error code in case of failure, e.g. storing
> > the error in a global variable 'ret' and adding a final:
> > 
> > exit $ret
> the above lines are equal to "exit $ret".
> the exit code in testup() will return if it's not 0.
> Do you mean I should make it more clear?

I admit I initially did not notice that the posted code is equivalent
to

exit $ret

so perhaps make it more explicit could help :) Not a big deal anyway.

Thanks,

Paolo


Return-Path: <linux-sctp+bounces-2-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05014813705
	for <lists+linux-sctp@lfdr.de>; Thu, 14 Dec 2023 17:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D23281999
	for <lists+linux-sctp@lfdr.de>; Thu, 14 Dec 2023 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF561FC7;
	Thu, 14 Dec 2023 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NqCXb7sx"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2141128
	for <linux-sctp@vger.kernel.org>; Thu, 14 Dec 2023 08:55:21 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d08a924fcfso79038065ad.2
        for <linux-sctp@vger.kernel.org>; Thu, 14 Dec 2023 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702572921; x=1703177721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RT0eLBOuatp2ygshln82AgJR3wQooxj/VsT49bwyvIQ=;
        b=NqCXb7sxhjz9xGUDoz/1gi/ekPJY2bMnBJ3YBqJKjwueWblzuqBXNcL6vWX86nyHJJ
         KUnz/sheGaEYuzZDWorHryYTdx0dII9NHv2ZYdit3etmk7+7zoT007vw5S4hsxyTaKpN
         CJZtOmTstanLHisPf7Tg+DCrVV/SLt2WZeLBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572921; x=1703177721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT0eLBOuatp2ygshln82AgJR3wQooxj/VsT49bwyvIQ=;
        b=n0ARHloVpwDJnKbO321SEnr8leWcsXrWcxaMCzk0z8JuFdadYEX7WIR0hjKoLcxGTT
         E5ZAjdyIWc720iiMpBUVbLlt6yYLxqahgsAxNbRiMEoCjpRiXUBD6j+WIT9HniFikj5S
         +ExK7dhOgClHPU9QN/zQlS/ZRSOM67Z+FAkuAw9ux1VC/SK+ec+lMi1b8kTfPaQi8dAb
         0CSWQnYKwPWxGtgTZS9yjgz0bKtkFk7xYKzU/tBOpEaw5kUkZPAd+B81F8S1y8w2W2oq
         ivMQjq27V4qNriA1auO+x3BYFz1zLBxcJOZIhQVp6GfuTAX27FfigLpuQcdUCJNXiueS
         kXow==
X-Gm-Message-State: AOJu0Yxn9eQHvlO/Y3AMeD/fbPl3Wh51kgpSfKoH2Zt57MOvfxIJSEWG
	DANlS97Ng+9LID05hbaNXSeW4Q==
X-Google-Smtp-Source: AGHT+IG4XvFgs67+AtS9EHL/SznNMa+1UOsCgnL3cqhhPLl/kUPt3YMZFxwHRgtaH6dXWE/wh2zlOw==
X-Received: by 2002:a17:902:e54a:b0:1d0:ab0e:9154 with SMTP id n10-20020a170902e54a00b001d0ab0e9154mr12216205plf.125.1702572921180;
        Thu, 14 Dec 2023 08:55:21 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902694a00b001cc311ef152sm12601924plt.286.2023.12.14.08.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:55:20 -0800 (PST)
Date: Thu, 14 Dec 2023 08:55:19 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 0/6] sctp: fix a plenty of flexible-array-nested
 warnings
Message-ID: <202312140839.18D3593E9F@keescook>
References: <cover.1681917361.git.lucien.xin@gmail.com>
 <20230419181824.10119070@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419181824.10119070@kernel.org>

On Wed, Apr 19, 2023 at 06:18:24PM -0700, Jakub Kicinski wrote:
> On Wed, 19 Apr 2023 11:16:27 -0400 Xin Long wrote:
> > Paolo noticed a compile warning in SCTP,
> > 
> > ../net/sctp/stream_sched_fc.c: note: in included file (through ../include/net/sctp/sctp.h):
> > ../include/net/sctp/structs.h:335:41: warning: array of flexible structures
> > 
> > But not only this, there are actually quite a lot of such warnings in
> > some SCTP structs. This patchset fixes most of warnings by deleting
> > these nested flexible array members.
> > 
> > After this patchset, there are still some warnings left:
> > 
> >   # make C=2 CF="-Wflexible-array-nested" M=./net/sctp/
> >   ./include/net/sctp/structs.h:1145:41: warning: nested flexible array
> >   ./include/uapi/linux/sctp.h:641:34: warning: nested flexible array
> >   ./include/uapi/linux/sctp.h:643:34: warning: nested flexible array
> >   ./include/uapi/linux/sctp.h:644:33: warning: nested flexible array
> >   ./include/uapi/linux/sctp.h:650:40: warning: nested flexible array
> >   ./include/uapi/linux/sctp.h:653:39: warning: nested flexible array
> > 
> > the 1st is caused by __data[] in struct ip_options, not in SCTP;
> > the others are in uapi, and we should not touch them.
> > 
> > Note that instead of completely deleting it, we just leave it as a
> > comment in the struct, signalling to the reader that we do expect
> > such variable parameters over there, as Marcelo suggested.
> 
> Hi Kees, is there no workaround for nested flexible arrays within 
> the kernel?  Any recommendations?
> 
> https://lore.kernel.org/all/cover.1681917361.git.lucien.xin@gmail.com/

*thread necromancy*

Hi, I apologize for missing this thread back in April!

There's no need for a work-around: this situation isn't a problem.
Composite structures that end with a flexible array are perfectly valid
(the compiler can unambiguously reason about sizes). So none of these
patches are needed (and actually reduce the compiler's ability to reason
about object sizes). We shouldn't run sparse with -Wflexible-array-nested
as this isn't an actual problem.

The only problem that can happen like this is when a flex array
ends up in the _middle_ of a composite structure, in which
case yes, this needs to be fixed. This check is supported by
GCC 14+ with -Wflex-array-member-not-at-end. For example, see:
https://lore.kernel.org/all/1da736106d8e0806aeafa6e471a13ced490eae22.1698117815.git.gustavoars@kernel.org/

-Kees

-- 
Kees Cook

